-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_user_role_rid
-- Type: INDEX

-- Name: ix_kxp_user_role_rid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_user_role_rid ON kxp.kxp_user_role USING btree (role_id);


--
