-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_state_activity_report_state_name_idx
-- Type: INDEX

-- Name: upstox_state_activity_report_state_name_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE UNIQUE INDEX upstox_state_activity_report_state_name_idx ON labupstox.labupstox_state_activity_report USING btree (state_name);


--
