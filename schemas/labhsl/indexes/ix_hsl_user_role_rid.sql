-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_user_role_rid
-- Type: INDEX

-- Name: ix_hsl_user_role_rid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_user_role_rid ON labhsl.labhsl_user_role USING btree (role_id);


--
