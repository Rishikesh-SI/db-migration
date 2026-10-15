-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: index_userguid
-- Type: INDEX

-- Name: index_userguid; Type: INDEX; Schema: labgt_02042024; Owner: -
--

CREATE INDEX index_userguid ON labgt_02042024.labgt_web_user USING btree (user_guid);


--
