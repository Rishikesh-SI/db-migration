-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: idx_user_activity_report
-- Type: INDEX

-- Name: idx_user_activity_report; Type: INDEX; Schema: labmao; Owner: -
--

CREATE UNIQUE INDEX idx_user_activity_report ON labmao.labmao_user_activity_report USING btree (user_id);


--
