-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_user_role_rid
-- Type: INDEX

-- Name: ix_cfc_user_role_rid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_user_role_rid ON cfc.cfc_user_role USING btree (role_id);


--
