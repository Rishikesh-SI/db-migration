-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_user_role_rid
-- Type: INDEX

-- Name: ix_spz_user_role_rid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_user_role_rid ON spz.spz_user_role USING btree (role_id);


--
