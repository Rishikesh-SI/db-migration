-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: idx_state_activity_report
-- Type: INDEX

-- Name: idx_state_activity_report; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE UNIQUE INDEX idx_state_activity_report ON labtcs.labtcs_state_activity_report USING btree (state_name);


--
