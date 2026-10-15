-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: index_emailid
-- Type: INDEX

-- Name: index_emailid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX index_emailid ON dd_30_04_24.dd_web_user USING btree (upper_email_id);


--
