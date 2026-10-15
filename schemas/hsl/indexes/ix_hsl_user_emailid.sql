-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_user_emailid
-- Type: INDEX

-- Name: ix_hsl_user_emailid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_user_emailid ON hsl.hsl_user USING btree (email_id);


--
