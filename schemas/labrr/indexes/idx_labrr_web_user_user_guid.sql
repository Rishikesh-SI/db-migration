-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: idx_labrr_web_user_user_guid
-- Type: INDEX

-- Name: idx_labrr_web_user_user_guid; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX idx_labrr_web_user_user_guid ON labrr.labrr_web_user USING btree (user_guid);


--
