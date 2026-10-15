-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: index_emailid
-- Type: INDEX

-- Name: index_emailid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX index_emailid ON dd.dd_web_user USING btree (upper_email_id);


--
