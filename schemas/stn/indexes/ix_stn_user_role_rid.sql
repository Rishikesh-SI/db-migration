-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_user_role_rid
-- Type: INDEX

-- Name: ix_stn_user_role_rid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_user_role_rid ON stn.stn_user_role USING btree (role_id);


--
