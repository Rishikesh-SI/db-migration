-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: idx_user_activity_report
-- Type: INDEX

-- Name: idx_user_activity_report; Type: INDEX; Schema: labrao; Owner: -
--

CREATE UNIQUE INDEX idx_user_activity_report ON labrao.labrao_user_activity_report USING btree (user_id);


--
