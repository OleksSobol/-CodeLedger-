import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../database/app_database.dart';
import 'shell_scaffold.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/clients/presentation/pages/clients_list_page.dart';
import '../../features/clients/presentation/pages/client_detail_page.dart';
import '../../features/clients/presentation/pages/client_form_page.dart';
import '../../features/projects/presentation/pages/project_form_page.dart';
import '../../features/time_tracking/presentation/pages/time_tracking_page.dart';
import '../../features/time_tracking/presentation/pages/clock_in_page.dart';
import '../../features/time_tracking/presentation/pages/manual_entry_page.dart';
import '../../features/time_tracking/presentation/pages/edit_time_entry_page.dart';
import '../../features/invoices/presentation/pages/invoices_list_page.dart';
import '../../features/invoices/presentation/pages/invoice_detail_page.dart';
import '../../features/invoices/presentation/pages/invoice_wizard_client_page.dart';
import '../../features/invoices/presentation/pages/invoice_wizard_entries_page.dart';
import '../../features/invoices/presentation/pages/invoice_wizard_review_page.dart';
import '../../features/reports/presentation/pages/reports_page.dart';
import '../../features/backup/presentation/pages/backup_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _timeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'time');
final _invoicesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'invoices');
final _settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ShellScaffold(navigationShell: navigationShell),
      branches: [
        // Branch 0: Home / Dashboard
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: '/',
              name: 'dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),

        // Branch 1: Time Tracking
        StatefulShellBranch(
          navigatorKey: _timeNavigatorKey,
          routes: [
            GoRoute(
              path: '/time-tracking',
              name: 'timeTracking',
              builder: (context, state) => const TimeTrackingPage(),
              routes: [
                GoRoute(
                  path: 'clock-in',
                  name: 'clockIn',
                  builder: (context, state) => const ClockInPage(),
                ),
                GoRoute(
                  path: 'manual',
                  name: 'manualEntry',
                  builder: (context, state) => const ManualEntryPage(),
                ),
                GoRoute(
                  path: 'edit',
                  name: 'editTimeEntry',
                  builder: (context, state) {
                    final entry = state.extra as TimeEntry;
                    return EditTimeEntryPage(entry: entry);
                  },
                ),
              ],
            ),
          ],
        ),

        // Branch 2: Invoices
        StatefulShellBranch(
          navigatorKey: _invoicesNavigatorKey,
          routes: [
            GoRoute(
              path: '/invoices',
              name: 'invoices',
              builder: (context, state) => const InvoicesListPage(),
              routes: [
                GoRoute(
                  path: 'create',
                  name: 'invoiceCreate',
                  builder: (context, state) =>
                      const InvoiceWizardClientPage(),
                  routes: [
                    GoRoute(
                      path: 'entries',
                      name: 'invoiceCreateEntries',
                      builder: (context, state) =>
                          const InvoiceWizardEntriesPage(),
                    ),
                    GoRoute(
                      path: 'review',
                      name: 'invoiceCreateReview',
                      builder: (context, state) =>
                          const InvoiceWizardReviewPage(),
                    ),
                  ],
                ),
                GoRoute(
                  path: ':invoiceId',
                  name: 'invoiceDetail',
                  builder: (context, state) {
                    final invoiceId =
                        int.parse(state.pathParameters['invoiceId']!);
                    return InvoiceDetailPage(invoiceId: invoiceId);
                  },
                ),
              ],
            ),
          ],
        ),

        // Branch 3: Settings
        StatefulShellBranch(
          navigatorKey: _settingsNavigatorKey,
          routes: [
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),

    // Full-screen routes (pushed on root navigator, no bottom nav)
    GoRoute(
      path: '/profile',
      name: 'profile',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/clients',
      name: 'clients',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ClientsListPage(),
      routes: [
        GoRoute(
          path: 'add',
          name: 'clientAdd',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const ClientFormPage(),
        ),
        GoRoute(
          path: ':clientId',
          name: 'clientDetail',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            final clientId =
                int.parse(state.pathParameters['clientId']!);
            return ClientDetailPage(clientId: clientId);
          },
          routes: [
            GoRoute(
              path: 'edit',
              name: 'clientEdit',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                final client = state.extra as dynamic;
                return ClientFormPage(client: client);
              },
            ),
            GoRoute(
              path: 'projects/add',
              name: 'projectAdd',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                final clientId =
                    int.parse(state.pathParameters['clientId']!);
                return ProjectFormPage(clientId: clientId);
              },
            ),
            GoRoute(
              path: 'projects/:projectId/edit',
              name: 'projectEdit',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                final clientId =
                    int.parse(state.pathParameters['clientId']!);
                final project = state.extra as dynamic;
                return ProjectFormPage(
                    clientId: clientId, project: project);
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/reports',
      name: 'reports',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ReportsPage(),
    ),
    GoRoute(
      path: '/backup',
      name: 'backup',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const BackupPage(),
    ),
  ],
);
