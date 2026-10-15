-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labgsoc; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labgsoc.labgsoc_user USING btree (email_id);


--
