-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: index_emailid
-- Type: INDEX

-- Name: index_emailid; Type: INDEX; Schema: lablsg_v1; Owner: -
--

CREATE INDEX index_emailid ON lablsg_v1.lablsg_v1_web_user USING btree (upper_email_id);


--
