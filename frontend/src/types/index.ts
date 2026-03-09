// ── M1: Auth & User Management ──

export type UserRole =
  | "delivery_manager"
  | "sales"
  | "practice_lead"
  | "admin"
  | "executive";

export interface Profile {
  id: string;
  full_name: string;
  email: string;
  role: UserRole;
  department: string | null;
  account_assigned: string | null;
  profile_photo: string | null;
  is_active: boolean;
  created_at: string;
  last_login: string | null;
}

// ── M2: Account & Client Master ──

export type AccountStatus = "active" | "inactive" | "prospect";

export interface Account {
  account_id: string;
  account_name: string;
  industry: string | null;
  region: string | null;
  account_owner_id: string | null;
  sales_lead_id: string | null;
  practice_leader_id: string | null;
  contract_value: number | null;
  engagement_start: string | null;
  engagement_end: string | null;
  account_status: AccountStatus;
  created_at: string;
}

// ── M3: Lead Submission ──

export type LeadType = "cross_sell" | "upsell" | "new_service" | "expansion";
export type LeadStatus =
  | "draft"
  | "submitted"
  | "under_review"
  | "qualified"
  | "won"
  | "lost"
  | "dropped";
export type Priority = "high" | "medium" | "low";

export interface Lead {
  lead_id: string;
  title: string;
  description: string;
  lead_type: LeadType;
  account_id: string;
  submitted_by: string;
  estimated_value: number | null;
  currency: string;
  probability: number | null;
  expected_close_date: string | null;
  status: LeadStatus;
  priority: Priority;
  supporting_docs: string[];
  ai_category: string | null;
  ai_confidence: number | null;
  value_score: number | null;
  created_at: string;
  updated_at: string;
  // Joined fields
  account?: Account;
  submitter?: Profile;
}

// ── M4: Value Idea Submission ──

export type IdeaCategory =
  | "automation"
  | "cost_optimization"
  | "efficiency"
  | "risk_reduction"
  | "innovation"
  | "process_improvement";
export type IdeaStatus =
  | "draft"
  | "submitted"
  | "under_review"
  | "approved"
  | "in_progress"
  | "implemented"
  | "rejected";
export type EffortLevel = "low" | "medium" | "high";

export interface ValueIdea {
  idea_id: string;
  title: string;
  problem_statement: string;
  proposed_solution: string;
  idea_category: IdeaCategory;
  account_id: string;
  submitted_by: string;
  estimated_saving: number | null;
  estimated_effort: EffortLevel;
  estimated_timeline: string | null;
  impact_area: string[];
  tools_involved: string[];
  status: IdeaStatus;
  ai_category: string | null;
  ai_summary: string | null;
  ai_confidence: number | null;
  value_score: number | null;
  supporting_docs: string[];
  created_at: string;
  updated_at: string;
  // Joined fields
  account?: Account;
  submitter?: Profile;
}

// ── API Response types with joined fields ──

export type LeadWithRelations = Lead & {
  account?: { account_id: string; account_name: string; industry?: string; region?: string };
  submitter?: { id: string; full_name: string; email: string; role?: string };
};

export type IdeaWithRelations = ValueIdea & {
  account?: { account_id: string; account_name: string; industry?: string; region?: string };
  submitter?: { id: string; full_name: string; email: string; role?: string };
};

// ── M5: Assignment Engine ──

export type SubmissionType = "lead" | "idea";
export type AssignedRole =
  | "account_owner"
  | "sales_lead"
  | "practice_leader"
  | "review_committee";
export type ActionTaken =
  | "pending"
  | "reviewed"
  | "approved"
  | "rejected"
  | "escalated";

export interface Assignment {
  assignment_id: string;
  submission_type: SubmissionType;
  submission_id: string;
  assigned_to: string;
  assigned_role: AssignedRole;
  assigned_by: "system" | "manual";
  assignment_date: string;
  due_date: string | null;
  action_taken: ActionTaken;
  action_date: string | null;
  notes: string | null;
  created_at: string;
}

export interface AssignmentWithRelations extends Assignment {
  assignee?: { id: string; full_name: string; email: string; role: string };
  submission_title?: string;
  submission_status?: string;
  account_name?: string;
}

// ── M6: Notifications ──

export type NotificationType =
  | "reminder"
  | "escalation"
  | "status_update"
  | "approval"
  | "info";
export type NotificationChannel = "email" | "in_app" | "slack";

export interface Notification {
  notification_id: string;
  recipient_id: string;
  submission_type: SubmissionType;
  submission_id: string;
  type: NotificationType;
  message: string;
  channel: NotificationChannel;
  is_read: boolean;
  sent_at: string;
  read_at: string | null;
}

// ── M7: Tracking ──

export interface StatusHistory {
  history_id: string;
  submission_type: SubmissionType;
  submission_id: string;
  from_status: string;
  to_status: string;
  changed_by: string;
  changed_at: string;
  reason: string | null;
}

export interface Comment {
  comment_id: string;
  submission_type: SubmissionType;
  submission_id: string;
  author_id: string;
  content: string;
  created_at: string;
  is_internal: boolean;
  author?: Profile;
}

// ── M8: Value Score ──

export type ScoreEventType =
  | "submitted"
  | "approved"
  | "implemented"
  | "qualified"
  | "deal_won";

export interface ScoreEvent {
  event_id: string;
  user_id: string;
  submission_type: SubmissionType;
  submission_id: string;
  event_type: ScoreEventType;
  points_awarded: number;
  awarded_at: string;
}

export interface UserScore {
  score_id: string;
  user_id: string;
  total_points: number;
  leads_submitted: number;
  ideas_submitted: number;
  deals_won: number;
  ideas_implemented: number;
  period: string;
  rank: number;
  updated_at: string;
}

// ── M9: Leaderboard ──

export type LeaderboardCategory =
  | "top_contributor"
  | "revenue_leader"
  | "value_champion"
  | "top_team";

export interface LeaderboardEntry {
  entry_id: string;
  category: LeaderboardCategory;
  entity_type: "user" | "team";
  entity_id: string;
  rank: number;
  score: number;
  period: "monthly" | "quarterly" | "annual";
  period_label: string;
  badge: string | null;
  generated_at: string;
}

// ── M10: AI Classification ──

export interface AIClassificationLog {
  log_id: string;
  submission_type: SubmissionType;
  submission_id: string;
  input_text: string;
  raw_response: Record<string, unknown>;
  assigned_category: string;
  confidence_score: number;
  ai_summary: string;
  suggested_assignees: Record<string, unknown>;
  human_override: boolean;
  override_by: string | null;
  model_used: string;
  processed_at: string;
}

// ── M11: Dashboards ──

export type MetricType = "revenue" | "savings" | "count" | "score";

export interface DashboardMetric {
  metric_id: string;
  metric_name: string;
  metric_value: number;
  metric_type: MetricType;
  account_id: string | null;
  user_id: string | null;
  period: string;
  computed_at: string;
}

// ── M12: Governance ──

export interface ReviewCycle {
  cycle_id: string;
  cycle_type: "monthly" | "quarterly";
  period_label: string;
  start_date: string;
  end_date: string;
  facilitator_id: string;
  status: "planned" | "in_progress" | "completed";
  submissions_reviewed: number;
  notes: string | null;
}

export interface ImpactMeasurement {
  impact_id: string;
  submission_type: SubmissionType;
  submission_id: string;
  revenue_influenced: number | null;
  cost_saved: number | null;
  efficiency_gain: string | null;
  measured_by: string;
  measurement_date: string;
  verified: boolean;
}
