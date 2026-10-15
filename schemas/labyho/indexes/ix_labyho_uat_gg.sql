-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_labyho_uat_gg
-- Type: INDEX

-- Name: ix_labyho_uat_gg; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX ix_labyho_uat_gg ON ONLY labyho.labyho_user_action_tracking USING btree (guest_guid);


--
