-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: index_userguid
-- Type: INDEX

-- Name: index_userguid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX index_userguid ON dd_30_04_24.dd_web_user USING btree (user_guid);


--
