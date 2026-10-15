-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_user_emailid
-- Type: INDEX

-- Name: ix_hsl_user_emailid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_user_emailid ON labhsl.labhsl_user USING btree (email_id);


--
