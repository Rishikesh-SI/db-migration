-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: index_userguid
-- Type: INDEX

-- Name: index_userguid; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX index_userguid ON labrr.labrr_web_user USING btree (user_guid);


--
