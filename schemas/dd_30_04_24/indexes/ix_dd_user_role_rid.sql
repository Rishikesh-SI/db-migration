-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_user_role_rid
-- Type: INDEX

-- Name: ix_dd_user_role_rid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_user_role_rid ON dd_30_04_24.dd_user_role USING btree (role_id);


--
