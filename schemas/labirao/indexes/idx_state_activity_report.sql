-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: idx_state_activity_report
-- Type: INDEX

-- Name: idx_state_activity_report; Type: INDEX; Schema: labirao; Owner: -
--

CREATE UNIQUE INDEX idx_state_activity_report ON labirao.labirao_state_activity_report USING btree (state_name);


--
