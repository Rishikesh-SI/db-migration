-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: idx_corporate_activity_report
-- Type: INDEX

-- Name: idx_corporate_activity_report; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE UNIQUE INDEX idx_corporate_activity_report ON labtcs.labtcs_corporate_activity_report USING btree (group_name);


--
