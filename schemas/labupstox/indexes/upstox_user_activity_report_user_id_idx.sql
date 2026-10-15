-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_user_activity_report_user_id_idx
-- Type: INDEX

-- Name: upstox_user_activity_report_user_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE UNIQUE INDEX upstox_user_activity_report_user_id_idx ON labupstox.labupstox_user_activity_report USING btree (user_id);


--
