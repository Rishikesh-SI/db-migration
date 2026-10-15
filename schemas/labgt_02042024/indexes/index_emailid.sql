-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: index_emailid
-- Type: INDEX

-- Name: index_emailid; Type: INDEX; Schema: labgt_02042024; Owner: -
--

CREATE INDEX index_emailid ON labgt_02042024.labgt_web_user USING btree (upper_email_id);


--
