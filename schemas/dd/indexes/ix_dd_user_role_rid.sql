-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_user_role_rid
-- Type: INDEX

-- Name: ix_dd_user_role_rid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_user_role_rid ON dd.dd_user_role USING btree (role_id);


--
