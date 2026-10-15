-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_user_action_tracking_2020_guest_guid_idx
-- Type: INDEX ATTACH

-- Name: labyho_user_action_tracking_2020_guest_guid_idx; Type: INDEX ATTACH; Schema: labyho; Owner: -
--

ALTER INDEX labyho.ix_labyho_uat_gg ATTACH PARTITION labyho.labyho_user_action_tracking_2020_guest_guid_idx;


--
