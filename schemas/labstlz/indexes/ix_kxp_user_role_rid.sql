-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_user_role_rid
-- Type: INDEX

-- Name: ix_kxp_user_role_rid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_user_role_rid ON labstlz.labstlz_user_role USING btree (role_id);


--
