-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: idx_labgt01_v1_web_user_guid
-- Type: INDEX

-- Name: idx_labgt01_v1_web_user_guid; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX idx_labgt01_v1_web_user_guid ON labgt01_v1.labgt01_v1_web_user USING btree (user_guid);


--
