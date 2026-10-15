-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: index_userguid
-- Type: INDEX

-- Name: index_userguid; Type: INDEX; Schema: labkc_v1_02042024; Owner: -
--

CREATE INDEX index_userguid ON labkc_v1_02042024.labkc_v1_web_user USING btree (user_guid);


--
