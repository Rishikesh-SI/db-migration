-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_user_emailid
-- Type: INDEX

-- Name: ix_upy_user_emailid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_user_emailid ON upy.upy_user USING btree (email_id);


--
