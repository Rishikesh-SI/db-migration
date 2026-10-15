-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_user_role_rid
-- Type: INDEX

-- Name: ix_ppb_user_role_rid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_user_role_rid ON ppb.ppb_user_role USING btree (role_id);


--
