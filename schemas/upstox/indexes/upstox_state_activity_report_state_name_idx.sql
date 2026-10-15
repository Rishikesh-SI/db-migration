-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_state_activity_report_state_name_idx
-- Type: INDEX

-- Name: upstox_state_activity_report_state_name_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE UNIQUE INDEX upstox_state_activity_report_state_name_idx ON upstox.upstox_state_activity_report USING btree (state_name);


--
