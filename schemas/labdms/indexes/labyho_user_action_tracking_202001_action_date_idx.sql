-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labyho_user_action_tracking_202001_action_date_idx
-- Type: INDEX

-- Name: labyho_user_action_tracking_202001_action_date_idx; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX labyho_user_action_tracking_202001_action_date_idx ON labdms.labdms_user_action_tracking_202001 USING btree (action_date);


--
