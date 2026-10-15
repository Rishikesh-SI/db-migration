-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: idx_corporate_activity_report
-- Type: INDEX

-- Name: idx_corporate_activity_report; Type: INDEX; Schema: dhm; Owner: -
--

CREATE UNIQUE INDEX idx_corporate_activity_report ON dhm.dhm_corporate_activity_report USING btree (group_name);


--
