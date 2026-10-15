-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: ix_labyho_up_ug
-- Type: INDEX

-- Name: ix_labyho_up_ug; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX ix_labyho_up_ug ON labdms.labdms_user_preferences USING btree (user_guid);


--
