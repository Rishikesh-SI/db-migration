-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_user_emailid
-- Type: INDEX

-- Name: ix_spz_user_emailid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_user_emailid ON spz.spz_user USING btree (email_id);


--
