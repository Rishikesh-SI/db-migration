-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_user_role_rid
-- Type: INDEX

-- Name: ix_zeven_user_role_rid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_user_role_rid ON zeven.zeven_user_role USING btree (role_id);


--
