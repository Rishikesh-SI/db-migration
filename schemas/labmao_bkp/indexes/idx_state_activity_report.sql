-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: idx_state_activity_report
-- Type: INDEX

-- Name: idx_state_activity_report; Type: INDEX; Schema: labmao_bkp; Owner: -
--

CREATE UNIQUE INDEX idx_state_activity_report ON labmao_bkp.labmao_state_activity_report USING btree (state_name);


--
