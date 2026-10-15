-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: idx_web_user_completed_profile
-- Type: INDEX

-- Name: idx_web_user_completed_profile; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX idx_web_user_completed_profile ON labgt01_v1.labgt01_v1_web_user USING btree ((((created_date + '05:30:00'::interval))::date)) WHERE ((first_name IS NOT NULL) AND ((first_name)::text <> ''::text) AND (last_name IS NOT NULL) AND ((last_name)::text <> ''::text));


--
