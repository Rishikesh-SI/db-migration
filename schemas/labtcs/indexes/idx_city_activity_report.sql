-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: idx_city_activity_report
-- Type: INDEX

-- Name: idx_city_activity_report; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE UNIQUE INDEX idx_city_activity_report ON labtcs.labtcs_city_activity_report USING btree (city, state_name);


--
