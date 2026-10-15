-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_city_activity_report_city_state_name_idx
-- Type: INDEX

-- Name: upstox_city_activity_report_city_state_name_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE UNIQUE INDEX upstox_city_activity_report_city_state_name_idx ON labupstox.labupstox_city_activity_report USING btree (city, state_name);


--
