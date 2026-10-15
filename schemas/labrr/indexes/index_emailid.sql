-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: index_emailid
-- Type: INDEX

-- Name: index_emailid; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX index_emailid ON labrr.labrr_web_user USING btree (upper_email_id);


--
