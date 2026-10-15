-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labpc; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labpc.labpc_user_role USING btree (role_id);


--
