-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: idx_state_activity_report
-- Type: INDEX

-- Name: idx_state_activity_report; Type: INDEX; Schema: labrao; Owner: -
--

CREATE UNIQUE INDEX idx_state_activity_report ON labrao.labrao_state_activity_report USING btree (state_name);


--
