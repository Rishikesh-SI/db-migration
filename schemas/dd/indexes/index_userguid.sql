-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: index_userguid
-- Type: INDEX

-- Name: index_userguid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX index_userguid ON dd.dd_web_user USING btree (user_guid);


--
