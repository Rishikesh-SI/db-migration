-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: mv_user_activity
-- Type: MATERIALIZED VIEW

-- Name: mv_user_activity; Type: MATERIALIZED VIEW; Schema: labrao; Owner: -
--

CREATE MATERIALIZED VIEW labrao.mv_user_activity AS
 SELECT labrao_user_activity_master.user_activity_id,
    labrao_user_activity_master.user_id,
    labrao_user_activity_master.email_id,
    labrao_user_activity_master.activity_date,
    labrao_user_activity_master.activity_time,
    labrao_user_activity_master.distance,
    labrao_user_activity_master.created_date,
    labrao_user_activity_master.bib_no,
    labrao_user_activity_master.updated_date,
    labrao_user_activity_master.run_id,
    labrao_user_activity_master.runner_id,
    labrao_user_activity_master.datasource,
    labrao_user_activity_master.activity_link,
    labrao_user_activity_master.activity_start_time
   FROM labrao.labrao_user_activity_master
  WHERE (labrao_user_activity_master.activity_date < now())
  WITH NO DATA;


--
