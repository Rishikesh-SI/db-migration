-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_labgt_web_user_guid
-- Type: INDEX

-- Name: idx_labgt_web_user_guid; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_labgt_web_user_guid ON labgt.labgt_web_user USING btree (user_guid);


--
