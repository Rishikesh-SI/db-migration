-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_user_role_rid
-- Type: INDEX

-- Name: ix_mum_user_role_rid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_user_role_rid ON dhm.dhm_user_role USING btree (role_id);


--
