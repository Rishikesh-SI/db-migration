-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_user_role_rid
-- Type: INDEX

-- Name: ix_yho_user_role_rid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_user_role_rid ON yho.yho_user_role USING btree (role_id);


--
