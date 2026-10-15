-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_corporate_activity_report_group_name_idx
-- Type: INDEX

-- Name: upstox_corporate_activity_report_group_name_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE UNIQUE INDEX upstox_corporate_activity_report_group_name_idx ON upstox.upstox_corporate_activity_report USING btree (group_name);


--
