-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_user_activity_report_user_id_idx
-- Type: INDEX

-- Name: upstox_user_activity_report_user_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE UNIQUE INDEX upstox_user_activity_report_user_id_idx ON upstox.upstox_user_activity_report USING btree (user_id);


--
