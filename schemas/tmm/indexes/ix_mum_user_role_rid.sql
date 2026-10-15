-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_user_role_rid
-- Type: INDEX

-- Name: ix_mum_user_role_rid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_user_role_rid ON tmm.tmm_user_role USING btree (role_id);


--
