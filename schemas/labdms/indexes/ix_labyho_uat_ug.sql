-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: ix_labyho_uat_ug
-- Type: INDEX

-- Name: ix_labyho_uat_ug; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX ix_labyho_uat_ug ON ONLY labdms.labdms_user_action_tracking USING btree (user_guid);


--
